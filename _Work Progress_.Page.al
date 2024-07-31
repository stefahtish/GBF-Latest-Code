page 51007 "Work Progress"
{
    PageType = List;
    SourceTable = "Work Progress";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("% Progress"; Rec."% Progress")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        //"SubTotal(3to9)":=
    end;

    var
        "SubTotal(3to9)": Decimal;
        "cummRet(11+12)": Decimal;
        "SubTotal(10-13)": Decimal;
        "CummRec(16+17)": Decimal;
        "BalAdv(15-18)": Decimal;
        "CumNetCont(14-18)": Decimal;
        "Net ducCONT(20-21)": Decimal;
        TotalDUECONTRCR: Decimal;
}
