package ServiceNet.hmi.service;

public interface IServiceNetListener {
   public void vncClientConnected(String clientIp);
   public void vncClientDisconnected(String clientIp);
}
