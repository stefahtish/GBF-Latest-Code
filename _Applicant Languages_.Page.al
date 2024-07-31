page 51292 "Applicant Languages"
{
    PageType = listpart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Applicants Lang. Proficiency";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Language; Rec.Language)
                {
                    ApplicationArea = All;
                }
                field(Read; Rec.Read)
                {
                    ApplicationArea = All;
                }
                field(Write; Rec.Write)
                {
                    ApplicationArea = All;
                }
                field(Speak; Rec.Speak)
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    Editable = true;
                }
            }
        }
    }
}
