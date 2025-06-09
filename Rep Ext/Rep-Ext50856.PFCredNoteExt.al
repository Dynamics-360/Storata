reportextension 50856 PFCredNoteExt extends "PF Posted Sales Credit Memo"
{
    dataset
    {
    }
    rendering
    {
        layout("SalesCreditMemo - D360")
        {
            Type = RDLC;
            LayoutFile = './SalesCreditMemoModified.rdl';
        }
    }
}
