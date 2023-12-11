const { PrismaClient } = require("@prisma/client");
const message = require("../services/message");
const prisma = new PrismaClient();

/** footer link */
const footerLinkController = {
  getAllFooterLink: async (req, res) => {
    try {
      const data = await prisma.footerLink.findMany();
      if (data.length <= 0) {
        return res.status(204);
      }
      res.status(200).json({ data });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getAFooterLink: async (req, res) => {
    try {
      const { id } = req.query;

      const find = await prisma.footerLink.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }
      res.status(200).json({ data: find });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  createFooterLink: async (req, res) => {
    try {
      const { title, link, footerId } = req.body;
      const findFooter = await prisma.footer.findUnique({
        where: { id: footerId },
      });

      if (!findFooter) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      await prisma.footerLink.create({
        data: { title, link, footerId },
      });
      res.status(200).json({ message: message.CREATE_SUCCESS });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  updateFooterLink: async (req, res) => {
    try {
      const { id } = req.query;
      const { title, link, footerId } = req.body;
      const find = await prisma.footerLink.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      await prisma.footerLink.update({
        where: { id },
        data: {
          title,
          link,
          footerId,
        },
      });

      res.status(200).json({ message: message.UPDATE });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  deleteFooterLink: async (req, res) => {
    try {
      const { id } = req.query;
      const find = await prisma.footerLink.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }
      await prisma.footerLink.delete({
        where: { id },
      });
      res.status(200).json({ message: message.DELETE });
    } catch (err) {
      res.status(500).json(err);
    }
  },
};

/** footer */
const footerController = {
  getAllFooter: async (req, res) => {
    try {
      const data = await prisma.footer.findMany();
      if (data.length <= 0) {
        return res.status(204).json(null);
      }

      res.status(200).json({ data });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  getAFooter: async (req, res) => {
    try {
      const { id } = req.query;
      const find = await prisma.footer.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      res.status(200).json({ data: find });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  createFooter: async (req, res) => {
    try {
      const {
        contactTitle,
        contactText,
        facebookLink,
        youtubeLink,
        zaloLink,
        categoryTitle,
        supportTitle,
        address,
        phoneNumber,
        email,
        website,
        map,
      } = req.body;

      await prisma.footer.create({
        data: {
          contactTitle,
          contactText,
          facebookLink,
          youtubeLink,
          zaloLink,
          address,
          phoneNumber,
          email,
          website,
          categoryTitle,
          supportTitle,
          map,
        },
      });
      res.status(200).json({ message: message.CREATE_SUCCESS });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  updateFooter: async (req, res) => {
    try {
      const {
        contactTitle,
        contactText,
        facebookLink,
        youtubeLink,
        zaloLink,
        address,
        phoneNumber,
        email,
        website,
        categoryTitle,
        supportTitle,
        map,
      } = req.body;
      const { id } = req.query;

      const find = await prisma.footer.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      await prisma.footer.update({
        where: { id },
        data: {
          contactTitle,
          contactText,
          facebookLink,
          youtubeLink,
          address,
          phoneNumber,
          email,
          website,
          zaloLink,
          categoryTitle,
          supportTitle,
          map,
        },
      });

      res.status(200).json({ message: message.UPDATE });
    } catch (err) {
      res.status(500).json(err);
    }
  },

  deleteFooter: async (req, res) => {
    try {
      const { id } = req.query;
      const find = await prisma.footer.findUnique({ where: { id } });
      if (!find) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      await prisma.footer.delete({ where: { id } });
      res.status(200).json({ message: message.DELETE });
    } catch (err) {
      res.status(500).json(err);
    }
  },
};

module.exports = {
  footerLinkController,
  footerController,
};
