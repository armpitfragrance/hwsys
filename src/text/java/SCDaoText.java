import com.dao.SCDao;
import com.dao.impl.SCDaoImpl;
import com.entity.SC;
import org.junit.Test;

/**
 * 作者：youjiahao
 * 日期: 2020/12/14 14:25
 * 描述:
 */
public class SCDaoText {
    SCDao scDao = new SCDaoImpl();

    @Test
    public void insert() {
        SC sc=null;
        for (int i = 51; i <101 ; i++) {
            sc=new SC(1,i);
            System.out.println(scDao.insert(sc));
        }
    }

    @Test
    public void delete(){

    }
}
