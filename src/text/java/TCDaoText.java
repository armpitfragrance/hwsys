import com.dao.TCDao;
import com.dao.impl.TCDaoImpl;
import com.entity.TC;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 19:00
 * 描述:
 */
public class TCDaoText {
    TCDao tcDao = new TCDaoImpl();
    TC addTC = new TC(1, 2);
    TC addTC2 = new TC(1, 3);
    TC updateTC = new TC(1, 1, 22);

    @Test
    public void insert() {
        System.out.println(tcDao.insert(addTC));
        System.out.println(tcDao.insert(addTC2));
    }

    @Test
    public void delete() {
        System.out.println(tcDao.delete(1));
    }

    @Test
    public void update() {
        System.out.println(tcDao.update(updateTC));
    }

    @Test
    public void queryAll() {
        List<TC> tcList = tcDao.queryAll();
        System.out.println(tcList);
    }

    @Test
    public void queryUserById() {
        TC tc = tcDao.queryTCById(1);
        System.out.println(tc);
    }

    @Test
    public void queryPageTotalCounts() {
        System.out.println(tcDao.queryPageTotalCounts());
    }

    @Test
    public void queryUserByPage() {
//        List<TC> tcList = tcDao.queryTCByPage(0, 2);
//        System.out.println(tcList);
        System.out.println();
    }
}
