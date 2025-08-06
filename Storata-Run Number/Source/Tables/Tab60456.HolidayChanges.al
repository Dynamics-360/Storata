table 60456 "Holiday Changes"
{
    Caption = 'Holiday Changes';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Run No"; Code[20])
        {
            Caption = 'Run No';
            TableRelation = Runs;
        }
        field(2; "Date to be Replaced"; Date)
        {
            Caption = 'Date to be Replaced';
        }
        field(3; "New Date"; Date)
        {
            Caption = 'New Date';
        }
    }
    keys
    {
        key(PK; "Run No", "Date to be Replaced")
        {
            Clustered = true;
        }
    }
}
