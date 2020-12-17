import com.dao.HomeworkDao;
import com.dao.impl.HomeworkDaoImpl;
import com.entity.Homework;
import com.entity.HomeworkManageInfo;
import com.service.HomeworkService;
import com.service.impl.HomeworkServiceImpl;
import org.junit.Test;

import java.util.Iterator;
import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/12 10:15
 * 描述:
 */
public class HomeWorkDaoTest {
    HomeworkDao homeworkDao = new HomeworkDaoImpl();
    HomeworkService homeworkService=new HomeworkServiceImpl();

    @Test
    public void insert() {
        Homework homework=null;
        for (int i = 1; i < 51; i++) {
            homework=new Homework("n"+i,"dn"+i,"p"+i,i,1,"2020-12-15");
            System.out.println(homeworkDao.insert(homework));
        }
    }

    @Test
    public void update() {
        Homework homework = new Homework(1, "n1gai", "d1", "p1", 1, 1, "2020-12-12");
        System.out.println(homeworkDao.update(homework));
    }

    @Test
    public void query(){
       List<HomeworkManageInfo> list=homeworkDao.queryHomeworkByNameAndEndtime(0,10,1,"","2020-12-15");
//        Iterator iterator=list.iterator();
//        while (iterator.hasNext()){
//            HomeworkManageInfo homeworkManageInfo= (HomeworkManageInfo) iterator.next();
//            System.out.println(homeworkManageInfo.toString());
//        }
       System.out.println(list);
    }

}
