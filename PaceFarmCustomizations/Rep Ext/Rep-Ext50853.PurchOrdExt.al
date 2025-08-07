reportextension 50853 PurchOrdExt extends "PF Purchase Order"
{
    dataset
    {
        add("Purchase Header")
        {
            column(ABN_Value; GetABN())
            {
            }
        }
        add(RoundLoop)
        {
            column(VAT_Identifier; "Purchase Line"."VAT Identifier")
            {
            }
            column(ItemReference; "Purchase Line"."Item Reference No.")
            {

            }
        }
    }
    rendering
    {
        // layout("PurchOrder-D360")
        // {
        //     Type = RDLC;
        //     LayoutFile = './PFPurchaseOrder.rdl';
        // }
        layout("Purchase Order - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50853_PFPurchaseOrder.rdl';
        }
    }
    local procedure GetABN(): Text
    var
        CompanyInfo: Record "Company Information";
        ABNValue: Code[20];
        ABN: Code[20];
        FirstPart: Text;
        SecondPart: Text;
        ThirdPart: Text;
        ForthPart: Text;
    begin
        // CompanyInfo.Get();
        ABNValue := '50003529575';

        FirstPart := CopyStr(ABNValue, 1, 2);       // First 2 characters
        SecondPart := CopyStr(ABNValue, 3, 3);      // Next 3 characters
        ThirdPart := CopyStr(ABNValue, 6, 3);
        ForthPart := CopyStr(ABNValue, 9);
        // Remaining characters

        exit(FirstPart + ' ' + SecondPart + ' ' + ThirdPart + ' ' + ForthPart);

    end;
}
