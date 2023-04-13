const multer = require('multer');
const { removeAccents } = require('../src/services');

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/newsImages');
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + '_' + formatName;
        cb(null, fileName)
    }
});

const uploadNews = multer({storage});

module.exports = uploadNews;