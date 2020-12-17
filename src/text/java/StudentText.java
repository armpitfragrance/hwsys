import com.dao.StudentDao;
import com.dao.impl.StudentDaoImpl;
import com.entity.Student;
import org.junit.Test;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 14:32
 * 描述:
 */
public class StudentText {
    StudentDao studentDao=new StudentDaoImpl();
    @Test
    public void insert() {
        Student student=new Student();
        for (int i = 51; i < 101; i++) {
            student = new Student(i,2017000+i,"class"+i);
            System.out.println(studentDao.insert(student));
        }
    }

    @Test
    public void delete() {

    }
}
