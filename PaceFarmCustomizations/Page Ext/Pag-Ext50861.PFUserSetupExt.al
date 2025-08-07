pageextension 50861 PFUserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Dont Remove PostDate Override")
        {
            field("Can Modify Credit Limit"; Rec."Can Modify Credit Limit")
            {
                ApplicationArea = All;
                Caption = 'Can Modify Credit Limit';
                ToolTip = 'Indicates whether the user can modify the credit limit for customers.';
            }
            field("Sales Limit Override"; Rec."Sales Limit Override")
            {
                ApplicationArea = All;
                Caption = 'Sales Limit Override';
                ToolTip = 'Indicates whether the user can override sales limits for customers.';
            }
        }
    }
}
