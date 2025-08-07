codeunit 50851 PF_EventMgt
{
    Permissions = tabledata "Return Receipt Header" = RIMD;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterUpdateAfterPosting, '', false, false)]
    local procedure "Sales-Post_OnAfterUpdateAfterPosting"(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        ReturnRecpt: Record "Return Receipt Header";
        SalesHeaderRec: Record "Sales Header";
        WorkDesc: Text;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order" then
            exit;

        ReturnRecpt.Reset();
        ReturnRecpt.SetRange("Return Order No.", SalesHeader."No.");
        if ReturnRecpt.FindFirst() then begin
            if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
                WorkDesc := SalesHeaderRec.GetWorkDescription();
                if WorkDesc <> '' then begin
                    SetWorkDescription(ReturnRecpt, WorkDesc);
                    ReturnRecpt.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure "Sales-Post_OnBeforePostSalesDoc"(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    begin
        CustomUtility.CheckCreditLimit(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterModifyEvent, '', false, false)]
    local procedure UpdateCustomer(Rec: Record Customer; xRec: Record Customer)
    var
        UserSetup: Record "User Setup";
    begin
        if (Rec."Credit Limit (LCY)" <> xRec."Credit Limit (LCY)") And (Rec."Credit Limit (LCY)" <> 0) then
            if UserSetup.Get(UserId) then
                if not UserSetup."Can Modify Credit Limit" then
                    Error('You do not have permission to modify the credit limit for this customer.');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforePerformManualRelease, '', false, false)]
    local procedure "Release Sales Document_OnBeforePerformManualRelease"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        CustomUtility.CheckCreditLimit(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Return Receipt", OnAfterGetCurrRecordEvent, '', false, false)]
    local procedure UpdateNotes(Rec: Record "Return Receipt Header")
    begin
    end;

    procedure GetWorkDescription(var ReturnRecpt: Record "Return Receipt Header"): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        ReturnRecpt.CalcFields("Work Description");
        ReturnRecpt."Work Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), ReturnRecpt.FieldName("Work Description")));
    end;

    // procedure GetWorkDescrReturnOrder(SalesHead: Record "Sales Header"): Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     SalesHead.CalcFields("Work Description");
    //     SalesHead."Work Description".CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), SalesHead.FieldName("Work Description")));
    // end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", OnBeforeOnRun, '', false, false)]
    local procedure "Company-Initialize_OnBeforeOnRun"()
    begin
        CustomUtility.ShowMsgForSandbox();
    end;

    procedure SetWorkDescription(var ReturnRecpt: Record "Return Receipt Header"; NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear(ReturnRecpt."Work Description");
        ReturnRecpt."Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
    end;

    var
        CustomUtility: Codeunit PF_CustomUtility;

}
