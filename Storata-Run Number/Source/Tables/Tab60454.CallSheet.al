table 60454 "Call Sheet"
{
    Caption = 'Call Sheet';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            Editable = false;
        }
        field(3; "Run No"; Code[20])
        {
            Caption = 'Run No';
            TableRelation = Runs;
            Editable = false;
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
        field(11; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(12; Called; Boolean)
        {
            Caption = 'Called';
        }
        field(13; "Call Back"; Boolean)
        {
            Caption = 'Call Back';
        }
        field(14; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(15; Holidays; Integer)
        {
            Caption = 'Holidays';
            Editable = false;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
