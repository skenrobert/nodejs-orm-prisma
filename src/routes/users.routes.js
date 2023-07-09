import { Router } from "express";
import { prisma } from "../db.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const router = Router();

router.get("/users", async (req, res, next) => {
  try {
    // get all user findMany
    const users = await prisma.user.findMany({
      // include: {
      // 	category: true,
      // },
    });
    res.json(users);
  } catch (error) {
    next(error);
  }
});

router.post("/users", async (req, res, next) => {
  const salt = bcrypt.genSaltSync(10);
  // const hash = bcrypt.hashSync(myPlaintextPassword, salt);

  try {
    let body = req.body;
    let { username, email, password } = body;

    let userObj = {
      username,
      email,
      //password: bcrypt.hashSync(password, salt)
      password: await bcrypt.hash(password, 10),
    };

    const user = await prisma.user.create({
      data: userObj,
    });
    // console.log({user});
    res.json(user);
  } catch (error) {
    console.log({ error });
    next(error);
  }
});

// **************************************************************

router.post("/login", async (req, res, next) => {
  const email = req.body.email ? req.body.email : "";
  const password = req.body.password ? req.body.password : "";

  if (email != "" && password != "") {
    try {
      const userdb = await prisma.user.findUnique({
        where: {
          email: email,
        },
      });

      if (userdb != null) {
        if (
          !bcrypt.compareSync(password, userdb.password ? userdb.password : "")
        ) {
          // res.sendStatus(400);
          res.sendStatus(400).json({
            ok: false,
            err: {
              message: "incorrect password",
            },
          });
        } else {
          const user = { userdb };
          // expiresIn: process.env.CADUCIDAD_TOKEN
          const token = jwt.sign({ user }, "my_secret_key", {
            expiresIn: "10h",
          });
          res.json({
            user: userdb,
            msj: "is ready jwt",
            token,
          });
        }
      } else {
        res.sendStatus(400).json({
          err: {
            message: "incorrect email",
          },
          ok: false,
        });
      }
    } catch (error) {
      // console.log({error});
      // console.log(error);
      // console.log(error.stack);
      next(error);
    }
  } else {
    console.log("empty");
  }
});

router.get("/proctected", middletoken, (req, res) => {
  jwt.verify(req.token, "my_secret_key", (err, data) => {
    if (err) {
      res.sendStatus(403);
    } else {
      res.json({
        test: "protected",
        data,
      });
    }
  });
});

router.get("/logout", (req, res) => {
//   req.session.destroy(() => {
//     res.redirect("/");
//   });
});

function middletoken(req, res, next) {
  const bearerHeader = req.headers["authorization"];
  console.log(bearerHeader);
  if (typeof bearerHeader != "undefined") {
    const bearer = bearerHeader.split(" ");
    const bearerToken = bearer[1];
    req.token = bearerToken;
    next();
  } else {
    res.sendStatus(403);
  }
}

export default router;
