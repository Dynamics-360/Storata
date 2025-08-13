table 50855 Driver
{
    Caption = 'Driver';
    DataClassification = CustomerContent;
    LookupPageId = Driver;
    DrillDownPageId = Driver;

    fields
    {
        field(1; "Driver No."; Code[20])
        {
            Caption = 'Driver No.';
        }
        field(2; "Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Driver No.")
        {
            Clustered = true;
        }
    }
}
