table 50853 "Warehouse Supervisor"
{
    Caption = 'Warehouse Supervisor';
    DataClassification = CustomerContent;
    LookupPageId = "Warehouse Supervisor";
    DrillDownPageId = "Warehouse Supervisor";

    fields
    {
        field(1; "Supervisor No."; Code[20])
        {
            Caption = 'Supervisor No.';
        }
        field(2; "Supervisor Name"; Text[100])
        {
            Caption = 'Supervisor Name';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Supervisor No.")
        {
            Clustered = true;
        }
    }
}
