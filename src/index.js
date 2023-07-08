import express from "express";
import productRoutes from "./routes/products.routes.js";
import categoryRoutes from "./routes/categories.routes.js";
import userRoutes from "./routes/users.routes.js";
import jwt from "jsonwebtoken";

const app = express();

app.use(express.json());

app.use("/api", productRoutes);
app.use("/api", categoryRoutes);
app.use("/api", userRoutes);

app.post("/api/login", async (req, res, next) => {

    const email = req.body.email;
    const password = req.body.user;

    
    if(email != "" && password != ""){
        try {
                const userdb = await prisma.user.findOne({ email: email }); 

             res.json(userdb);

        } catch (error) {
            // console.log({error});
            console.log(error);
            console.log(error.stack);
            next(error);
        }


    }else{
        console.log('empty');
    }


    const user = {id: 3}
    const token = jwt.sign({user}, 'my_secret_key', {expiresIn: '10h'});  
    res.json({
            msj : "nodejs and jwt",
            token
        });
});


app.get('/api/proctected', middletoken, (req, res)=> {
    jwt.verify(req.token, 'my_secret_key', (err, data) => {
        if(err){
            res.sendStatus(403);
        }else {
            res.json({
                test: 'protected',
                data
            });
        }
    });
});


function middletoken(req, res, next){
    const bearerHeader = req.headers['authorization'];
    console.log(bearerHeader);
    if(typeof bearerHeader != 'undefined'){
        const bearer = bearerHeader.split(" ");
        const bearerToken = bearer[1];
        req.token = bearerToken;
        next();
    }else{ 
        res.sendStatus(403);
    }
}


app.listen(3000);
console.log("Server on port", 3000);