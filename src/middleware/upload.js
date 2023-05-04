const multer = require('multer');
const { removeAccents } = require('../services/index');



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


const banner = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/banner');
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + "_" + formatName;
        cb(null, fileName);
    }
});

const uploadBanner = multer({storage: banner});

const avatar = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/avatar')
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));

        const fileName = Date.now() + "_" + formatName;

        cb(null, fileName)
    }
});

const uploadAvatar = multer({storage:avatar});

const fixPost = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/fixPostImage')
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + '_' + formatName;

        cb(null, fileName)

    }
});

const uploadFixPost = multer({storage: fixPost});

const newPost = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/newsImages');
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + '_' + formatName;
        cb(null, fileName)
    }
});

const uploadNews = multer({storage: newPost});


const logo = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/logo');
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + "_" + formatName;

        cb(null, fileName);
    }
});

const uploadLogo = multer({storage: logo});


const youtube = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, process.cwd() + '/public/youtubeImage');
    },
    filename: (req, file, cb) => {
        const formatName = removeAccents(file.originalname.split(' ').join('-'));
        const fileName = Date.now() + '_' + formatName;

        cb(null, fileName);
    }
});

const uploadYoutube = multer({storage: youtube})



module.exports = {
    upload,
    uploadBanner,
    uploadAvatar,
    uploadFixPost,
    uploadNews,
    uploadLogo,
    uploadYoutube
};