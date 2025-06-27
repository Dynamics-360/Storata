table 60450 Runs
{
    Caption = 'Runs';
    DataClassification = ToBeClassified;
    LookupPageId = "Run Numbers List";

    fields
    {
        field(1; "Run No"; Code[20])
        {
            Caption = 'Run No';
        }
        field(2; Warehouse; Code[10])
        {
            Caption = 'Warehouse';
            TableRelation = Location;
        }
        field(3; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(4; "Warehouse Name"; Text[100])
        {
            Caption = 'Warehouse Name';
            Editable = false;
        }
        field(5; Weekdays; Option)
        {
            Caption = 'Weekdays';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday;
        }
        field(6; Calender; Option)
        {
            Caption = 'Calender';
            OptionMembers = " ","NSW 24/5","GEN 24/7","VIC 24/5","QLD 24/5","SA 24/5","ACT 24/5";
        }
        field(7; "Lead Time"; Integer)
        {
            Caption = 'Lead Time';
        }
        field(8; Inactive; Boolean)
        {
            Caption = 'Inactive';
        }
    }
    keys
    {
        key(PK; "Run No")
        {
            Clustered = true;
        }
    }
}
