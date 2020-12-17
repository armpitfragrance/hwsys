import com.dao.UserDao;
import com.dao.impl.UserDaoImpl;
import com.entity.User;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 19:00
 * 描述:
 */
public class UserDaoText {
    UserDao userDao = new UserDaoImpl();
    User addUser = new User("管理员", "123", "youxdao1", "男", 22);
    User addUser2 = new User("管理员", "123", "youxdao2", "男", 22);
    User updateUser = new User(1, "管理员", "123gai", "youxdao1", "男", 22);

    @Test
    public void insert() {
        User user=null;
        for (int i = 101; i <151; i++) {
            user=new User("老师","123","老师"+i,"男",20);
            System.out.println(userDao.insert(user));
        }
    }

    @Test
    public void delete() {
        System.out.println(userDao.delete(2));
    }

    @Test
    public void update() {
        System.out.println(userDao.update(updateUser));
    }

    @Test
    public void queryAll() {
        List<User> userList = userDao.queryAll();
        System.out.println(userList);
    }

    @Test
    public void queryUserById() {
        User user = userDao.queryUserById(1);
        System.out.println(user);
    }

    @Test
    public void queryPageTotalCounts() {
        System.out.println(userDao.queryPageTotalCounts());
    }

    @Test
    public void queryUserByPage() {
        List<User> userList = userDao.queryUserByPage(0,2);
        System.out.println(userList);
    }
}
