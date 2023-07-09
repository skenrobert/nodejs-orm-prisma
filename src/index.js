import express from "express";
import productRoutes from "./routes/products.routes.js";
import categoryRoutes from "./routes/categories.routes.js";
import userRoutes from "./routes/users.routes.js";


// import jwt from "jsonwebtoken";
// import { prisma } from "./db.js";
// import bcrypt  from "bcrypt";

const app = express();

app.use(express.json());

app.use("/api", productRoutes);
app.use("/api", categoryRoutes);
app.use("/api", userRoutes);

// app.post("/api/login", async (req, res, next) => {

//     const email = req.body.email? req.body.email: '' ;
//     const password = req.body.password? req.body.password: '' ;

    
//     if(email != "" && password != ""){
//             try {
//                     const userdb = await prisma.user.findUnique({ 
//                         where: {
//                             email: email,
//                         },
//                     });  

//                     if(userdb != null){
//                         if(! bcrypt.compareSync(password ,userdb.password? userdb.password: '')){
//                             // res.sendStatus(400);
//                             res.sendStatus(400).json({
//                                 ok: false,
//                                 err: {
//                                 message: "incorrect password"
//                                 }
//                             });
//                         }else {

//                             const user = {userdb};
//                             // expiresIn: process.env.CADUCIDAD_TOKEN
//                             const token = jwt.sign({user}, 'my_secret_key', {expiresIn: '10h'});  
//                             res.json({
//                                     user: userdb,
//                                     msj : "is ready jwt",
//                                     token
//                                 });
//                         }
//                     }else{
//                         res.sendStatus(400).json({
//                             err: {
//                                 message: "incorrect email"
//                                 },
//                             ok: false

//                         });

//                     }    
                        
//             } catch (error) {
//                 // console.log({error});
//                 // console.log(error);
//                 // console.log(error.stack);
//                 next(error);
//             }

//     }else{
//         console.log('empty');
//     }

// });


// app.get('/api/proctected', middletoken, (req, res)=> {
//     jwt.verify(req.token, 'my_secret_key', (err, data) => {
//         if(err){
//             res.sendStatus(403);
//         }else {
//             res.json({
//                 test: 'protected',
//                 data
//             });
//         }
//     });
// });

// function middletoken(req, res, next){
//     const bearerHeader = req.headers['authorization'];
//     console.log(bearerHeader);
//     if(typeof bearerHeader != 'undefined'){
//         const bearer = bearerHeader.split(" ");
//         const bearerToken = bearer[1];
//         req.token = bearerToken;
//         next();
//     }else{ 
//         res.sendStatus(403);
//     }
// }


app.listen(3000);
console.log("Server on port", 3000);