const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const message = require('../services/message');

 
/********** LOCATION_TYPE **********/
const getAllLocationType = async (req, res) => {
    try {

        const data = await prisma.location_type.findMany();

        if (data.length <= 0) {
            return res.status(204).json();
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailLocationType = async (req, res) => {
    try {

        const { id } = req.query;

        const data = await prisma.location_type.findFirst({
            where: {
                id: String(id)
            }
        });

        if (!data) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createLocationType = async (req, res) => {
    try {

        const { typeName } = req.body;
        
        const data = await prisma.location_type.create({
            data: { name: typeName }
        });

        res.status(200).json({ data, message: message.CREATE_SUCCESS })

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateLocationType = async (req, res) => {
    try {

        const { id } = req.query;
        const { typeName } = req.body;

        const find = await prisma.location_type.findFirst({
            where: { id: String(id) },
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND })
        };

        const data = await prisma.location_type.update({
            where: {
                id: String(id),
            },
            data: { name: typeName }
        });

        res.status(200).json({ data, message: message.UPDATE });

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteLocationType = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.location_type.findFirst({
            where: { id: String(id) }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.location_type.delete({
            where: { id: String(id) }
        });

        res.status(200).json({ message: message.DELETE })

    } catch (err) {
        res.status(500).json(err);
    };
};


/********** COUNTRY **********/

const getAllCountry = async (req, res) => {
    try {

        const data = await prisma.country.findMany({
            include: {
                provinceList: {
                    orderBy: { code: 'asc' },
                    include: {
                        district: {
                            orderBy: { code: 'asc' },
                            include: {
                                commune: {
                                    orderBy: { code: 'asc' }
                                }
                            }
                        }
                    }
                }
            }
        });

        if (data.length <= 0) {
            return res.status(204).json()
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailCountry = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.country.findFirst({
            where: {
                id: String(id)
            },
            include: {
                provinceList: {
                    orderBy: { code: "asc" },
                    include: {
                        district: {
                            orderBy: { code: 'asc' },
                            include: {
                                commune: {
                                    orderBy: { code: 'asc' }
                                }
                            }
                        }
                    }
                }
            }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data: find })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createCountry = async (req, res) => {
    try {

        const { name, code, codeName } = req.body;

        const data = await prisma.country.create({
            data: { name, code: code * 1, codeName }
        });

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateCountry = async (req, res) => {
    try {

        const { id } = req.query;
        const { name, code, codeName } = req.body;


        const find = await prisma.country.findFirst({
            where: { id: String(id) },
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.country.update({
            where: { id: String(id) },
            data: { name, code, codeName },
        });

        res.status(200).json({ message: message.UPDATE });

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteCountry = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.country.findFirst({
            where: { id: String(id) }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.country.delete({
            where: { id: String(id) },
        });

        res.status(200).json({ message: message.DELETE });

    } catch (err) {
        res.status(500).json(err);
    };
};



/********** PROVINCE **********/

const getAllProvince = async (req, res) => {
    try {

        const data = await prisma.province.findMany({
            orderBy: { code: 'asc' }
        });

        if (data.length <= 0) {
            return res.status(204).json()
        };

        res.status(200).json({ data: data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailProvince = async (req, res) => {
    try {

        const { id } = req.query;

        const data = await prisma.province.findFirst({
            where: { id: String(id) },
            include: {
                typeName: true,
                country: true,
                district: {
                    orderBy: { code: 'asc' },
                    include: {
                        commune: {
                            orderBy: { code: 'asc' }
                        }
                    }
                },
            }
        });

        if (!data) {

            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getProvinceWithPerPage = async (req, res) => {
    try {

        const { page, perPage } = req.query;

        const Page = Number(page);
        const PerPage = Number(perPage);

        if (Page <= 0) {
            Page = 1;
        };

        if (PerPage <= 0) {
            PerPage = 10;
        };

        const total = await prisma.province.count();
        const totalPage = Math.ceil(total / PerPage);
        const currentPage = Math.min(Page, totalPage);
        const skip = (currentPage - 1) * PerPage;

        const data = await prisma.province.findMany({
            take: PerPage,
            skip: skip,
            orderBy: {
                code: 'asc'
            }
        });

        res.status(200).json({ data, total, totalPage, currentPage })


    } catch (err) {
        res.status(500).json(err);
    };
};

const createProvince = async (req, res) => {
    try {

        const { name, code, codeName, typeId, countryId } = req.body;

        const newData = await prisma.province.create({
            data: { name, code: code * 1, codeName, typeId: String(typeId), countryId: String(countryId) }
        })

        res.status(200).json({ data: newData })

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateProvince = async (req, res) => {
    try {
        const { id } = req.query;
        const { name, code, codeName, typeId, countryId } = req.body;

        const province = await prisma.province.update({
            where: { id },
            data: {
                name,
                code: code && +code, // Convert the string to a number using the unary plus operator
                codeName,
                typeId: typeId && String(typeId),
                countryId: countryId && String(countryId),
            },
            select: { name: true }, // Only select the "name" field to return
        });

        if (!province) {
            return res.status(404).json({ message: message.NOT_FOUND });
        }

        res.status(200).json({ message: message.UPDATE });
    } catch (err) {
        res.status(500).json(err);
    }
};

const deleteProvince = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.province.findFirst({
            where: { id: String(id) },
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.province.delete({
            where: { id: String(id) }
        });

        res.status(200).json({ message: message.DELETE });

    } catch (err) {
        res.status(500).json(err);
    };
};



/********** DISTRICT **********/

const getAllDistrict = async (req, res) => {
    try {

        const data = await prisma.district.findMany({
            orderBy: { code: 'asc' }
        });

        if (data.length <= 0) {
            return res.status(204).json();
        };

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailDistrict = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.district.findFirst({
            where: { id: String(id) },
            include: {
                type: true,
                commune: {
                    orderBy: { code: 'asc' }
                }
            }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data: find })

    } catch (err) {
        res.status(500).json(err);
    };
};

/** pagination and searching ***/
const getDistrictWithPerPage = async (req, res) => {
    try {

        const { page, perPage } = req.query;
        const { keyWord } = req.body;

        if (keyWord) {
            const data = await prisma.district.findMany({
                where: { name: {
                    contains: keyWord
                } }
            });

            return res.status(200).json({ data })
        }
        else {
            const Page = Number(page);
            const PerPage = Number(perPage);

            if (Page <= 0) Page = 1;
            if (PerPage <= 0) PerPage = 10;

            const total = await prisma.district.count();
            const totalPage = Math.ceil(total / perPage);
            const currentPage = Math.min(Page, totalPage);
            const skip = (currentPage - 1) * PerPage;

            const data = await prisma.district.findMany({
                take: PerPage,
                skip: skip,
                orderBy: { code: 'asc' }
            });

            res.status(200).json({ data, total, totalPage, currentPage })
        }

    } catch (err) {
        res.status(500).json(err);
    };
};

const createDistrict = async (req, res) => {
    try {

        const { name, code, codeName, typeId, provinceId } = req.body;

        const data = await prisma.district.create({
            data: {
                name,
                code: Number(code),
                codeName,
                typeId: String(typeId),
                provinceId: String(provinceId)
            }
        });

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateDistrict = async (req, res) => {
    try {

        const { id } = req.query;
        const { name, code, codeName, typeId, provinceId } = req.body;

        const find = await prisma.district.findFirst({
            where: { id }
        })

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.district.update({
            where: { id },
            data: {
                name,
                code: code && +code,
                codeName,
                typeId: typeId && String(typeId),
                provinceId: provinceId && String(provinceId)
            },
            select: { name: true }
        });

        res.status(200).json({ message: message.UPDATE });

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteDistrict = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.district.findFirst({ where: { id } });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.district.delete({ where: { id } });

        res.status(200).json({ message: message.DELETE });

    } catch (err) {
        res.status(500).json(err);
    };
};


/********** COMMUNE **********/
const getAllCommune = async (req, res) => {
    try {

        const data = await prisma.commune.findMany({
            orderBy: { code: 'asc' }
        })

        if (data.length <= 0) {
            return res.status(204).json()
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailCommune = async (req, res) => {
    try {

        const { id } = req.query;

        const findData = await prisma.commune.findFirst({
            where: { id: String(id) },
            include: {
                type: true,
                district: true
            }
        });

        if (!findData) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data: findData });

    } catch (err) {
        res.status(500).json(err);
    };
};


const createCommune = async (req, res) => {
    try {

        const { name, code, codeName, typeId, districtId } = req.body;

        const newData = await prisma.commune.create({
            data: {
                name,
                code: Number(code),
                codeName,
                typeId,
                districtId
            }
        });

        res.status(200).json({ data: newData });

    } catch (err) {
        res.status(500).json(err);
    };
};


const updateCommune = async (req, res) => {
    try {

        const { id } = req.query;
        const { name, code, codeName, typeId, districtId } = req.body;

        const find = await prisma.commune.findFirst({ where: { id: String(id) } });


        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.commune.update({
            where: { id },
            data: {
                name,
                code: code && Number(code),
                codeName,
                typeId: typeId && String(typeId),
                districtId: districtId && String(districtId)
            },
            select: { name: true }
        });

        res.status(200).json({ message: message.UPDATE });

    } catch (err) {
        res.status(500).json(err);
    };
};


const deleteCommune = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.commune.findFirst({
            where: { id: String(id) }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.commune.delete({
            where: { id: String(id) }
        });

        res.status(200).json({ message: message.DELETE });

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    /*****  location type  *****/
    getAllLocationType,
    getDetailLocationType,
    createLocationType,
    updateLocationType,
    deleteLocationType,

    /*****  country  *****/
    getAllCountry,
    getDetailCountry,
    createCountry,
    updateCountry,
    deleteCountry,

    /***** district  *****/
    getAllDistrict,
    getDetailDistrict,
    getDistrictWithPerPage,
    createDistrict,
    updateDistrict,
    deleteDistrict,

    /***** province  *****/
    getAllProvince,
    getDetailProvince,
    createProvince,
    updateProvince,
    deleteProvince,
    getProvinceWithPerPage,

    /*****  commune  *****/
    getAllCommune,
    getDetailCommune,
    createCommune,
    updateCommune,
    deleteCommune,
}
