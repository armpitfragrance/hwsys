import com.dao.NoticeDao;
import com.dao.impl.NoticeDaoImpl;
import com.entity.Notice;
import com.service.NoticeService;
import com.service.impl.NoticeServiceImpl;
import com.utils.Page;
import org.junit.Test;

import java.util.List;

/**
 * 作者：youjiahao
 * 日期: 2020/12/10 16:05
 * 描述:
 */
public class NoticeDaoText {
    NoticeDao noticeDao=new NoticeDaoImpl();
    NoticeService noticeService=new NoticeServiceImpl();
    @Test
    public void insert(){
        Notice notice=null;
        for (int i = 0; i <100 ; i++) {
            notice=new Notice("title"+i,"content"+i);
            noticeDao.insert(notice);
        }
    }

    @Test
    public void delete(){

    }

    @Test
    public void update(){

    }

    @Test
    public void queryAll(){

    }

    @Test
    public void queryUserById(){

    }

    @Test
    public void queryPageTotalCounts(){
        System.out.println(80%10);
    }

    @Test
    public void queryUserByPage(){
        Page<Notice> page= noticeService.queryByPage(1,10);
        System.out.println(page.getPageTotalCount());
        System.out.println(page.getPageTotal());
    }


}
