page 50424 "Professional Membership"
{
    PageType = ListPart;
    SourceTable = "Employee Prof Membership";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                }
                field(Organisation; Rec.Organisation)
                {
                }
                field("Date Admitted"; Rec."Date Admitted")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Annual Fee"; Rec."Annual Fee")
                {
                }
                field("Renewal Date"; Rec."Renewal Date")
                {
                }
                field("Company Pays Fees"; Rec."Company Pays Fees")
                {
                }
            }
        }
    }
    actions
    {
    }
}
