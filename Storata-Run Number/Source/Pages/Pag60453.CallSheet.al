page 60453 "Call Sheet"
{
    ApplicationArea = All;
    Caption = 'Call Sheet';
    PageType = List;
    SourceTable = "Call Sheet";
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer State"; Rec."Customer State")
                {
                    ToolTip = 'Specifies the value of the Customer State field.', Comment = '%';
                }
                field("Run No"; Rec."Run No")
                {
                    ToolTip = 'Specifies the value of the Run No field.', Comment = '%';
                }
                field("Run Day"; Rec."Run Day")
                {
                    ToolTip = 'Specifies the value of the Run Day field.', Comment = '%';
                }
                field("Run Date"; Rec."Run Date")
                {
                    ToolTip = 'Specifies the value of the Run Date field.', Comment = '%';
                }
                field("Call Day"; Rec."Call Day")
                {
                    ToolTip = 'Specifies the value of the Call Day field.', Comment = '%';
                }
                field("Call Group"; Rec."Call Group")
                {
                    ToolTip = 'Specifies the value of the Call Group field.', Comment = '%';
                }
                field("Call Date"; Rec."Call Date")
                {
                    ToolTip = 'Specifies the value of the Call Date field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field(Called; Rec.Called)
                {
                    ToolTip = 'Specifies the value of the Called field.', Comment = '%';
                }
                field("Call Back"; Rec."Call Back")
                {
                    ToolTip = 'Specifies the value of the Call Back field.', Comment = '%';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                }
                field(Holidays; Rec.Holidays)
                {
                    ToolTip = 'Specifies the value of the Holidays field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Customer)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Customer;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerCard: Page "Customer Card";
                begin
                    if Customer.Get(Rec."Customer No.") then begin
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();
                    end;
                end;
            }
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHead: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    CustomerSku: Record "Customer SKU";
                    SalesOrderPag: Page "Sales Order";
                    LineNo: Integer;
                begin
                    Clear(SalesHead);
                    Clear(SalesLine);
                    Clear(LineNo);
                    SalesHead.Init();
                    SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
                    SalesHead.Validate("Sell-to Customer No.", Rec."Customer No.");
                    SalesHead.Validate("Bill-to Customer No.", Rec."Customer No.");
                    SalesHead.validate("Document Date", Today);
                    SalesHead.Validate("Run No.", Rec."Run No");
                    if SalesHead.Insert(true) then begin
                        CustomerSku.Reset();
                        CustomerSku.SetRange("Customer No.", Rec."Customer No.");
                        if CustomerSku.FindFirst() then begin
                            repeat
                                SalesLine.Init;
                                LineNo += 10000;
                                SalesLine.validate("Document Type", SalesLine."Document Type"::Order);
                                SalesLine.Validate("Document No.", SalesHead."No.");
                                SalesLine.validate("Line No.", LineNo);
                                SalesLine.Validate(Type, SalesLine.Type::Item);
                                SalesLine.Validate("No.", CustomerSku."Item No.");
                                SalesLine.Insert();
                            until CustomerSku.Next() = 0;
                        end;
                    end;
                    // Commit();
                    Message('Order created for Customer %1', Rec."Customer No.");
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Customer No.") then begin
            Rec."Customer Name" := Customer.Name;
            Rec."Customer State" := Customer.County;
            Rec.Modify();
        end;
    end;

    local procedure CreateOrder()
    var
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustomerSku: Record "Customer SKU";
        CustRun: Record "Customer Runs";
        SalesLinesTemp: Record "Sales Line" temporary;
        SalesOrderPag: Page "Sales Order";
        Count: Integer;
        LineNo: Integer;
    begin
        if not ShowDefaultSKU() then
            exit;

        Count := 0;
        Clear(SalesHead);
        Clear(SalesLine);
        Clear(LineNo);
        SalesHead.Init();
        SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
        SalesHead.Validate("Sell-to Customer No.", Rec."Customer No.");
        SalesHead.Validate("Bill-to Customer No.", Rec."Customer No.");
        SalesHead.validate("Document Date", Today);
        SalesHead.Validate("Run No.", CustRun."Run No");
        if SalesHead.Insert(true) then begin
            Count += 1;
            SKUBuffer.Reset();
            SKUBuffer.SetFilter(Quantity, '>0');
            if SKUBuffer.FindFirst() then begin
                repeat
                    SalesLine.Init;
                    SalesLine.validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Document No.", SalesHead."No.");
                    LineNo += 10000;
                    SalesLine.validate("Line No.", LineNo);
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", SKUBuffer."Item No.");
                    SalesLine.Validate(Quantity, SKUBuffer.Quantity);
                    SalesLine.Validate("Run No.", CustRun."Run No");
                    SalesLine.Insert();
                until SKUBuffer.Next() = 0;
            end;
        end;
        // Commit();
        if Count > 0 then
            Message('%1 order created for Customer %2', Count, Rec."Customer No.");
    end;

    local procedure ShowDefaultSKU(): Boolean
    var
        CustomerSku: Record "Customer SKU";
        CustomSkUPag: Page CustomerSKUBuffer;
    begin
        SKUBuffer.DeleteAll();
        CustomerSku.Reset();
        CustomerSku.SetRange("Customer No.", Rec."Customer No.");
        if CustomerSku.FindSet() then begin
            repeat
                SKUBuffer.Init();
                SKUBuffer."Item No." := CustomerSku."Item No.";
                SKUBuffer.Desciption := CustomerSku.Desciption;
                SKUBuffer.Insert();
            until CustomerSku.Next() = 0;
        end;
        Commit();
        if SKUBuffer.FindSet() then begin
            CustomSkUPag.SetRecord(SKUBuffer);
            CustomSkUPag.LookupMode(true);
            CustomSkUPag.Editable(true);
            if CustomSkUPag.RunModal() = Action::LookupOK then
                exit(true)
            else
                exit(false);
        end;
    end;

    var
        SKUBuffer: Record DefaultSKUBuffer;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Closed, false);
    end;

}
