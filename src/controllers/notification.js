const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require("dotenv").config();
const { startOfDay, subDays, subMinutes, subHours } = require('date-fns')


const getAllNotification = async (req, res) => {
    try{
        const {filter} = req.query;
        if(filter && filter.seen) {
            if(filter.seen == "true"){
                filter.seen = true
            } else {
                filter.seen = false
            }
        } 
        const noti = await prisma.notification.findMany({
            where: filter
        });
        res.status(200).json({data: noti})
    } catch(err) {
        res.status(500).json(err);
    }
}

// udate status notification
const changeStatusNotification = async (req, res) => {
    try {   
        const {id} = req.query;
        if(id) {
            await prisma.notification.update({
                where: {id},
                data:{
                    seen: true
                }
            })
            
        } 
        res.status(200).json({message: "seen is true"})

    } catch (err) {
        res.status(500).json(err)
    }
}

// delete notification
const deleteNotification = async (req, res) => {
    const yesterday = subMinutes(new Date(), 1);
    try {
        await prisma.notification.deleteMany({
            where:{
                seen: true,
                updateAt:{
                    lt: yesterday
                }
            }
        })
        res.status(200).json({message: "noti is deleted"})
    } catch (err) {
        res.status(500).json(err)
    }
}

 module.exports = {getAllNotification, changeStatusNotification, deleteNotification}
