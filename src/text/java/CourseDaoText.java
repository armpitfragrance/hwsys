import com.dao.CourseDao;
import com.dao.impl.CourseDaoImpl;
import com.entity.Course;
import org.junit.Test;

/**
 * 作者：youjiahao
 * 日期: 2020/12/12 10:14
 * 描述:
 */
public class CourseDaoText {
    CourseDao courseDao = new CourseDaoImpl();

    @Test
    public void insert() {
        Course course = null;
        for (int i = 1; i < 51; i++) {
            course = new Course("c" + i, "p" + i);
            System.out.println(courseDao.insert(course));
        }
    }

    @Test
    public void update() {
        Course course = new Course(1, "c1gai", "p1");
        System.out.println(courseDao.update(course));
    }
}
