public class AstalNetwork.AccessPoint : Object {
    private Wifi wifi;
    private NM.AccessPoint ap;

    public uint bandwidth { get { return ap.bandwidth; } }
    public string bssid { owned get { return ap.bssid; } }
    public uint frequency { get { return ap.frequency; } }
    public int last_seen { get { return ap.last_seen; } }
    public uint max_bitrate { get { return ap.max_bitrate; } }
    public uint8 strength { get { return ap.strength; } }
    public NM.80211Mode mode { get { return ap.mode; } }
    public NM.80211ApFlags flags { get { return ap.flags; } }
    public NM.80211ApSecurityFlags rsn_flags { get { return ap.rsn_flags; } }
    public NM.80211ApSecurityFlags wpa_flags { get { return ap.wpa_flags; } }

    public string? ssid {
        owned get {
            if (ap.ssid == null)
                return null;

            return (string)NM.Utils.ssid_to_utf8(ap.ssid.get_data());
        }
    }

    internal AccessPoint(Wifi wifi, NM.AccessPoint ap) {
        this.wifi = wifi;
        this.ap = ap;
        ap.notify.connect((pspec) => {
            if (get_class().find_property(pspec.name) != null)
                notify_property(pspec.name);
        });
    }

    // TODO: connect to ap
    // public signal void auth();
    // public void try_connect(string? password) { }
}
