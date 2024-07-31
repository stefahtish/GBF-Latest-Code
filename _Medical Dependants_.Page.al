page 50485 "Medical Dependants"
{
    PageType = ListPart;
    SourceTable = "Medical Scheme Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Medical Scheme No"; Rec."Medical Scheme No")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field(SurName; Rec.SurName)
                {
                }
                field("Other Names"; Rec."Other Names")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                }
                field("Amount Spend (In-Patient)"; Rec."Amount Spend (In-Patient)")
                {
                }
                field("Amout Spend (Out-Patient)"; Rec."Amout Spend (Out-Patient)")
                {
                }
            }
        }
    }
    actions
    {
    }
}
