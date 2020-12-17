import com.dao.TeacherDao;
import com.dao.impl.TeacherDaoImpl;
import com.entity.Teacher;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 19:00
 * 描述:
 */
public class TeacherDaoText {
    TeacherDao teacherDao = new TeacherDaoImpl();
    Teacher addTeacher = new Teacher(1, 1001);
    Teacher addTeacher2 = new Teacher(2, 1002);
    Teacher updateTeacher = new Teacher(1, 1, 10011);

    @Test
    public void insert() {
        Teacher teacher=null;
        for (int i = 1; i < 51; i++) {
            teacher=new Teacher(i+100,i);
            System.out.println(teacherDao.insert(teacher));
        }

    }

    @Test
    public void delete() {
        System.out.println(teacherDao.delete(2));
    }

    @Test
    public void update() {
        System.out.println(teacherDao.update(updateTeacher));
    }

    @Test
    public void queryAll() {
        List<Teacher> teacherList = teacherDao.queryAll();
        System.out.println(teacherList);
    }

    @Test
    public void queryUserById() {
        Teacher teacher = teacherDao.queryTeacherById(1);
        System.out.println(teacher);
    }

    @Test
    public void queryPageTotalCounts() {
        System.out.println(teacherDao.queryPageTotalCounts());
    }

    @Test
    public void queryUserByPage() {
        List<Teacher> teacherList = teacherDao.queryTeacherByPage(0, 2);
        System.out.println(teacherList);
    }
}
