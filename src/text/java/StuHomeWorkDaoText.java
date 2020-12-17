import com.dao.HomeworkStuDao;
import com.dao.impl.HomeworkStuDaoImpl;
import com.entity.HomeworkStu;
import com.entity.HomeworkStuManageInfo;
import com.service.HomeworkStuService;
import com.service.impl.HomeworkStuServiceImpl;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/12 10:16
 * 描述:
 */
public class StuHomeWorkDaoText {
    HomeworkStuDao homeworkStuDao=new HomeworkStuDaoImpl();
    HomeworkStuService homeworkStuService=new HomeworkStuServiceImpl();
//    @Test
//    public void insert(){
//        HomeworkStu homeworkStu=new HomeworkStu(1,1,"2020-12-12","c1",1,100,"2020-12-13","已阅");
//        System.out.println(homeworkStuDao.insert(homeworkStu));
//    }
//    @Test
//    public void update(){
//        HomeworkStu homeworkStu=new HomeworkStu(2,1,1,"2020-12-12","c1gai",1,100,"2020-12-13","已阅");
//        System.out.println(homeworkStuDao.update(homeworkStu));
//    }
    @Test
    public void query(){
//        List<HomeworkStuManageInfo> list=homeworkStuService.queryHomeworkStuByHwNameAndEndtimeAndStatus(1,10,"","","").getItems();
//        System.out.println(list);
    }
}
