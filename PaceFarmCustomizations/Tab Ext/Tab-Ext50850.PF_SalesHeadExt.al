tableextension 50850 PF_SalesHeadExt extends "Sales Header"
{
    fields
    {
        field(50850; SDN; Code[200])
        {
            Caption = 'SDN';
            DataClassification = ToBeClassified;
        }
        field(50851; "Truck Rego"; Code[200])
        {
            Caption = 'Truck Rego';
            DataClassification = ToBeClassified;
        }
        field(50582; "Date Produced/UBD"; Date)
        {
            Caption = 'Date Produced/UBD';
            DataClassification = CustomerContent;
        }
        field(50583; "Warehouse Supervisor"; Code[20])
        {
            Caption = 'Warehouse Supervisor';
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Supervisor";
        }
        field(50860; "Product Relv. Temp."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Product Relevant Temp.';
        }
        field(50864; "Store Man"; Code[20])
        {
            Caption = 'Store Man';
            DataClassification = CustomerContent;
            TableRelation = Storeman;
        }
        field(50865; Carrier; Code[20])
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
            TableRelation = Carrier;
        }
        field(50866; Driver; Code[20])
        {
            Caption = 'Driver';
            DataClassification = CustomerContent;
            TableRelation = Driver;
        }
        field(50867; Product; Option)
        {
            Caption = 'Product';
            OptionMembers = "Shell Eggs","Chilled Egg","Frozen Egg","Powder Egg","Boiled Eggs";
            DataClassification = CustomerContent;
        }
        field(50868; "Action Taken"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Return to Stock","Quarantine Area";
            OptionCaption = 'Return to Stock(Temperature is within specifications and the product safety and quality has not been compromised),Quarantine Area';
        }
        field(50869; "Action Take Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Action Take comment';
        }
        field(50870; "Reason for Return Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Return Comment';
        }
        field(50871; "Delivery Terms"; Text[1024])
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Terms';
        }
        field(50872; "Date Received"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Received';
        }
        field(50873; Supersedes; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Supersedes';
        }
        field(50874; "Issue No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Issue No.';
        }
        field(50875; "Product Review"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Relevant Temp.';
            TableRelation = "Product Reviewer";
        }
        field(50876; "Condition Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Condition Comment';
        }

    }
}
