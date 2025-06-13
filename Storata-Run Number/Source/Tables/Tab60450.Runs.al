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
        field(4; "Description 2"; Text[200])
        {
            Caption = 'Description 2';
        }
        field(5; Weekdays; Option)
        {
            Caption = 'Weekdays';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(6; Calender; Option)
        {
            Caption = 'Calender';
            OptionMembers = " ","NSW 24/5","GEN 24/7","VIC 24/5","QLD 24/5","SA 24/5","ACT 24/5";
        }
        field(7; "Lead Time"; Decimal)
        {
            Caption = 'Lead Time';
        }
        field(8; Inactive; Boolean)
        {
            Caption = 'Inactive';
        }
        field(9; "Call Day"; Option)
        {
            Caption = 'Call Day';
            OptionMembers = ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
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
