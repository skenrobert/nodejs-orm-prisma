import { Router } from "express";
import { prisma } from "../db.js";

const router = Router();

router.get("/categories", async (req, res, next) => {
	try {
		const categories = await prisma.category.findMany({
			include: {
				products: true,
			},
		});
		res.json(categories);
	} catch (error) {
		next(error);
	}
});

router.post("/categories", async (req, res, next) => {

	// console.log({req});
	// console.log(req.body);
	try {
		const category = await prisma.category.create({
			data:  req.body,
			// data: {
			// 	name: req.name,
			//   },
		});
		res.json(category);
	} catch (error) {
		// console.log({error});
		next(error);
	}
});

export default router;