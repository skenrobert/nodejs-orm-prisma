import { Router } from "express";
import { prisma } from "../db.js";
import bcrypt  from "bcrypt";

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
            password: await bcrypt.hash(password,10)
          };

		const user = await prisma.user.create({
			data: userObj,
		});
		// console.log({user});
		res.json(user);
	} catch (error) {
		console.log({error});
		next(error);
	}
});

export default router;
