page 50288 "Apportionment Totals"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Apportionment Totals";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectDocs)
            {
                Caption = 'Select Documents';
                Image = SelectEntries;
                Visible = NOT HeaderPosted;

                trigger OnAction()
                begin
                    Apportionment.LookupDocuments(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetPageAppearance;
    end;

    trigger OnOpenPage()
    begin
        SetPageAppearance;
    end;

    var
        HeaderPosted: Boolean;
        Apportionment: Codeunit Apportionment;
        ApportionHeader: Record "Apportion Header";

    local procedure GetHeader()
    begin
        if ApportionHeader.Get(Rec."No.") then;
    end;

    local procedure SetPageAppearance()
    begin
        GetHeader;
        if ApportionHeader.Posted then
            HeaderPosted := true
        else
            HeaderPosted := false;
    end;
}
