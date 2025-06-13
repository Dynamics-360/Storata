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
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(5; "Run Date"; Date)
        {
            Caption = 'Run Date';
        }
        field(6; "Call Day"; Option)
        {
            Caption = 'Call Day';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(7; "Call Date"; Date)
        {
            Caption = 'Call Date';
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
