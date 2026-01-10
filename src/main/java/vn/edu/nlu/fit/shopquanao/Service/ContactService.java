package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.ContactDao;
import vn.edu.nlu.fit.shopquanao.model.Contact;

public class ContactService {
    private ContactDao contactDao = new ContactDao();

    public void addContact(Contact contact) {
        contactDao.addContact(contact);
    }
}
