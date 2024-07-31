page 50462 "Approved Recruitment Requests"
{
    Caption = 'Recruitment';
    PageType = List;
    SourceTable = "Recruitment Needs";
    CardPageId = "Recruitment Card";
    SourceTableView = WHERE(Status = CONST(Released));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Job ID"; Rec."Job ID")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field(Positions; Rec.Positions)
                {
                }
                field(Approved; Rec.Approved)
                {
                }
                field("Date Approved"; Rec."Date Approved")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Documentation Link"; Rec."Documentation Link")
                {
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Reason for Recruitment(text)"; Rec."Reason for Recruitment(text)")
                {
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                }
                field("Shortlisting Started"; Rec."Shortlisting Started")
                {
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                }
                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                }
            }
        }
    }
    actions
    {
    }
}
