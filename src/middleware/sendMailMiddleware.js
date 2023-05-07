require('dotenv')

const sgMail = require('@sendgrid/mail');

sgMail.setApiKey(process.env.SENDGRID_API_KEY);


const sendMail = async (msg) => {
    try {

        await sgMail.send(msg);
        console.log('Message sent successfully!')

    } catch (err) {

        console.error(err);

        if (err.response) {
            console.error(err.response.body)
        }

    }
};

module.exports = sendMail;

// sendMail({
//     to: "thanhtien200294@gmail.com",
//     from: "thanhtien2094@gmail.com",
//     subject: "Node js sent",
//     text: "this is you password"
// })

