table 50856 Carrier
{
    Caption = 'Carrier';
    DataClassification = CustomerContent;
    LookupPageId = Carrier;
    DrillDownPageId = Carrier;

    fields
    {
        field(1; "Carrier No."; Code[20])
        {
            Caption = 'Carrier No.';
        }
        field(2; "Carrier Name"; Text[100])
        {
            Caption = 'Carrier Name';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Carrier No.")
        {
            Clustered = true;
        }
    }
}
