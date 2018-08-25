package components;

import javax.jcr.Credentials;
import javax.jcr.Repository;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.container.ComponentManager;
import org.hippoecm.hst.site.HstServices;
import org.hippoecm.repository.util.RepoUtils;
import org.onehippo.cms7.essentials.components.CommonComponent;

public class ClusterNodeIdComponent extends CommonComponent {

    @Override
    public void doBeforeRender(final HstRequest request, final HstResponse response) {
        super.doBeforeRender(request, response);
        String clusterNodeId = RepoUtils.getClusterNodeId(getConfigUserSession());
        request.setAttribute("clusterNodeId", clusterNodeId);
    }

    private Session getConfigUserSession(){
        try {
            Repository repository = HstServices
                    .getComponentManager()
                    .getComponent(Repository.class.getName());
            ComponentManager mngr = HstServices.getComponentManager();
            Credentials configCred = mngr.getComponent(Credentials.class.getName() + ".hstconfigreader");
            Session mySession = repository.login(configCred);
            return mySession;
        } catch (RepositoryException ex) {
            return null;
        }
    }
}
