package composite.SingleCoreState;

public class SingleCoreState extends SingleCoreState_generated {
	private static final long serialVersionUID = 1L;

	public SingleCoreState() throws Exception {
		super();
	}

	public void setDeviceIdCoreComp(int iDeviceId) {
		super.setDeviceIdCoreComp(iDeviceId);
		markCoreIn.setVariable("Core" + iDeviceId + ".sv_bCoreIn");
		markCoreOut.setVariable("Core" + iDeviceId + ".sv_bCoreOut");
	}
}
