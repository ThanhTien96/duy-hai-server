const multer = require('multer');
const { removeAccents } = require('../src/services');



const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + "/public/images");
    },
    filename: (req, file , cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileNewName = Date.now() + "_" + formatName;
        cb(null, fileNewName)
    }
});

const upload = multer({storage});

module.exports = upload;