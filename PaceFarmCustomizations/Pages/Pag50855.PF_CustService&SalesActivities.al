page 50855 "PF_CustService&SalesActivities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    RefreshOnActivate = true;
    Caption = 'My Accounts';
    // SourceTable = TableName;

    layout
    {
        area(Content)
        {
            cuegroup("My Accounts")
            {
                ShowCaption = false;
                field(CustomerCue; CustomerCue)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    ToolTip = 'Number of customers assigned to the user.';
                    ShowCaption = true;
                    //Style = Favorable;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Customer List");
                    end;
                }
                field(RunsOpenCue; RunsOpenCue)
                {
                    ApplicationArea = All;
                    Caption = 'Runs Open';
                    //ToolTip = 'Number of open calls assigned to the user.';
                    //DrillDownPageId = "Call Sheet List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Customer Runs");
                    end;
                }
                field(RunsCallbackCue; RunsCallbackCue)
                {
                    ApplicationArea = All;
                    Caption = 'Runs Callback';
                    //ToolTip = 'Number of callback calls assigned to the user.';
                    //DrillDownPageId = "Call Sheet List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    var
                        CallSheet: Record "Call Sheet";
                    begin
                        CallSheet.SetRange("Call Back", true);
                        //CallSheet.FindSet();
                        Page.Run(Page::"Call Sheet", CallSheet);
                    end;
                }
                field(CallSheetCue; CallSheetCue)
                {
                    ApplicationArea = All;
                    Caption = 'Call Sheets';
                    //ToolTip = 'Number of call sheets assigned to the user.';
                    //DrillDownPageId = "Call Sheet List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Call Sheet");
                    end;
                }
                field(SalesOrdersCue; SalesOrdersCue)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    ToolTip = 'Number of sales orders assigned to the user.';
                    //DrillDownPageId = "Sales Order List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Sales Order List");
                    end;
                }
                field(SalesLinesCue; SalesLinesCue)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Lines';
                    ToolTip = 'Number of sales lines assigned to the user.';
                    // DrillDownPageId = "Sales Order List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Sales Order List");
                    end;
                }
                field(SalesCreditsCue; SalesCreditsCue)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credits';
                    ToolTip = 'Number of sales credit memos assigned to the user.';
                    // DrillDownPageId = "Sales Credit Memos";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Sales Credit Memos");
                    end;
                }
                field(transfercue; transfercue)
                {
                    ApplicationArea = All;
                    Caption = 'Transfers';
                    ToolTip = 'Number of transfer orders assigned to the user.';
                    // DrillDownPageId = "Transfer Orders";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Transfer Orders");
                    end;
                }
                field(ItemCue; ItemCue)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    ToolTip = 'Number of items assigned to the user.';
                    DrillDownPageId = "Item List";
                    ShowCaption = true;
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Item List");
                    end;
                }
            }
        }
    }

    var
        CustomerCue: Integer;
        RunsOpenCue: Integer;
        RunsCallbackCue: Integer;
        CallSheetCue: Integer;
        SalesOrdersCue: Integer;
        SalesLinesCue: Integer;
        SalesCreditsCue: Integer;
        transfercue: Integer;
        ItemCue: Integer;


    trigger OnOpenPage()
    var
        Customer: Record "Customer";
        RunsOpen: Record "Customer Runs";
        RunsCallback: Record "Call Sheet";
        CallSheet: Record "Call Sheet";
        SalesOrders: Record "Sales Header";
        SalesLines: Record "Sales Line";
        SalesCredits: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        Item: Record Item;
    begin

        CustomerCue := Customer.Count;

        RunsOpenCue := RunsOpen.Count;
        RunsCallback.SetRange("Call Back", true);
        RunsCallbackCue := RunsCallback.Count;

        CallSheetCue := CallSheet.Count;

        SalesOrders.SetRange("Document Type", SalesOrders."Document Type"::Order);
        SalesOrdersCue := SalesOrders.Count;

        SalesLines.SetRange("Document Type", SalesLines."Document Type"::Order);
        SalesLinesCue := SalesLines.Count;

        SalesCredits.SetRange("Document Type", SalesCredits."Document Type"::"Credit Memo");
        SalesCreditsCue := SalesCredits.Count;

        ItemCue := Item.Count;
        transfercue := TransferHeader.Count;

    end;

}