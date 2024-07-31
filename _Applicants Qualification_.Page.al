page 50497 "Applicants Qualification"
{
    PageType = List;
    SourceTable = "Employee Qualification";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                }
                field(Qualification; Rec.Qualification)
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                }
                field(Grade; Rec.Grade)
                {
                }
                field(Score; Rec.Score)
                {
                }
            }
        }
    }
    actions
    {
    }
}
