import com.jacob.com.*;
import com.jacob.activeX.*;

public class InternetExplorer
{
    public static void main(String[] args)
    {
        ActiveXComponent iecom = new ActiveXComponent("InternetExplorer.Application");
        Object ie = iecom.getObject();
        Dispatch.put(ie, "Visible", new Variant(true));
        IEEvents ieE = new IEEvents();
        DispatchEvents de = new DispatchEvents((Dispatch) ie,ieE,"InternetExplorer.Application");
        Dispatch.callSub(ie,"GoHome");
        try {
            while(Dispatch.get(ie,"Busy").toBoolean() == new Boolean(true)){
                Thread.sleep(4000);
            }
            Dispatch.call(ie,"Navigate",new Variant("http://www.ruby-lang.org/"));
            while(Dispatch.get(ie,"Busy").toBoolean() == new Boolean(true)){
                Thread.sleep(4000);
            }
            Dispatch document = Dispatch.get(ie,"Document").toDispatch();
            Dispatch all = Dispatch.get(document,"all").toDispatch();
            int num_element = Dispatch.get(all,"length").toInt();
            System.out.println("complete\n" + num_element + "elements found");
        }catch(InterruptedException e){
            e.printStackTrace();
        }finally{
            iecom.invoke("Quit",new Variant[]{});
        }
    }
}

class IEEvents
{
    public void DownloadComplete(Variant[] args) {
        System.out.println("DownloadComplete");
    }
}
