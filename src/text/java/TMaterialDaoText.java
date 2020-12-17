import com.dao.TMaterialDao;
import com.dao.impl.TMaterialDaoImpl;
import com.entity.TMaterial;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/9 19:00
 * 描述:
 */
public class TMaterialDaoText {
    TMaterialDao tMaterialDao = new TMaterialDaoImpl();
    TMaterial addTMaterial = new TMaterial("title1", "content1", "path1", "name1", 1);
    TMaterial addTMaterial2 = new TMaterial("title2", "content2", "path2", "name2", 2);
    TMaterial updateTMaterial = new TMaterial(2, "title1gai", "content1", "path1", "name1", 1);

    @Test
    public void insert() {
        System.out.println(tMaterialDao.insert(addTMaterial));
        System.out.println(tMaterialDao.insert(addTMaterial2));
    }

    @Test
    public void delete() {
        System.out.println(tMaterialDao.delete(2));
    }

    @Test
    public void update() {
        System.out.println(tMaterialDao.update(updateTMaterial));
    }

    @Test
    public void queryAll() {
        List<TMaterial> tMaterialList = tMaterialDao.queryAll();
        System.out.println(tMaterialList);
    }

    @Test
    public void queryUserById() {
        TMaterial tMaterial=tMaterialDao.queryTMaterialById(2);
        System.out.println(tMaterial);
    }

    @Test
    public void queryPageTotalCounts() {
        System.out.println(tMaterialDao.queryPageTotalCounts());
    }

    @Test
    public void queryUserByPage() {
        List<TMaterial> tMaterialList = tMaterialDao.queryTMaterialByPage(0,2);
        System.out.println(tMaterialList);
    }
}
