table 60451 "Customer Runs"
{
    Caption = 'Customer Runs';
    DataClassification = CustomerContent;
    LookupPageId = "Customer Runs";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(3; "Run No"; Code[20])
        {
            Caption = 'Run No';
            TableRelation = Runs;
        }
        field(4; "Run Day"; Option)
        {
            Caption = 'Run Day';
            Editable = false;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday;
        }
        field(5; "Run Date"; Date)
        {
            Caption = 'Run Date';
            Editable = false;
        }
        field(6; "Call Day"; Option)
        {
            Caption = 'Call Day';
            Editable = false;
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday;
        }
        field(7; "Call Date"; Date)
        {
            Caption = 'Call Date';
            Editable = false;
        }
        field(8; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
        field(9; "Customer State"; Text[30])
        {
            Caption = 'Customer State';
            Editable = false;
        }
        field(10; "Call Group"; Code[10])
        {
            Caption = 'Call Group';
        }
        field(11; Holidays; Integer)
        {
            Caption = 'Holidays';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Run No")
        {
            Clustered = true;
        }
    }
}
