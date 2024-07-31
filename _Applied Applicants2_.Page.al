page 51498 "Applied Applicants2"
{
    PageType = Listpart;
    SourceTable = "Applicant job applied";
    SourceTableView = where(Qualified = filter(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Application No."; Rec."Application No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Interview Date"; Rec."Interview Date")
                {
                }
                field("Interview Time"; Rec."Interview Time")
                {
                }
                field(Qualified; Rec.Qualified)
                {
                    Caption = 'System Qualified';
                }
                field(Shortlist; Rec.Shortlist)
                {
                }
            }
        }
    }
    actions
    {
    }
}
