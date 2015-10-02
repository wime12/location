#!/usr/bin/awk

BEGIN {
    in_result = 0;
    in_tag = 0;
    while (getXML(ARGV[1], 0)) {
        if (XTYPE == "TAG" && XITEM == "Result") {
            in_result = 1
            results++
        }
        else if (!in_result) {
            # ignore
        }
        else if (in_result && XTYPE == "TAG") {
            in_tag = 1
            current_tag = XITEM
        }
        else if (in_result && in_tag && XTYPE == "DAT") {
            current_data = XITEM
        }
        else if (in_result && in_tag &&
                 XTYPE == "END" && XITEM == current_tag) {
            data[results, current_tag] = current_data
            in_tag = 0
            current_tag = ""
            current_data = ""
        }
        else if (in_result && !in_tag && XTYPE == "DAT") {
            # ignore
        }
        else if (in_result && !in_tag &&
                 XTYPE == "END" && XITEM == "Result") {
            in_result = 0
        }
        else {
            print ("Structure error: ", ARGV[1], "line", XLINE) > "/dev/stderr"
            exit
        }
    }
    if (XERROR) {
        print("Parse error: ", ARGV[1], "line", XLINE) > "/dev/stderr"
        exit
    }
    # for (x in data)
    #     print x, "=", data[x]
    # if (ARGV[2])
    #    OFS=ARGV[2]
    # else
    #    OFS="|"
    # if (results)
    #     print("Nr", "City", "State", "Country", "ZIP", "Latitude",
    #           "Longitude", "WOEID")
    # for (i = 1; i <= results; i++) {
    #     print(i, data[i, "city"], data[i, "state"], data[i, "line4"],
    #           data[i, "uzip"], data[i,"latitude"], data[i,"longitude"],
    #           data[i, "woeid"])
    # }
    for (i = 1; i <= results; i++) {
	print(i ".", data[i, "city"] ",", data[i, "state"] ",", data[i, "line4"])
	print("\t" "Zip:", data[i, "uzip"])
	print("\t" "Latitude:", data[i, "latitude"] ",",
		   "Longitude:", data[i, "longitude"])
	print("\t" "WOEID:", data[i, "woeid"])
    }
}
