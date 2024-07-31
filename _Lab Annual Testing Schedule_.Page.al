page 50955 "Lab Annual Testing Schedule"
{
    Caption = 'Workplan Card';
    PageType = Card;
    SourceTable = "Lab Annual Testing Schedule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            Group(General)
            {
                Editable = not Rec.Scheduled;

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Nature of Testing"; Rec."Nature of Testing")
                {
                    Caption = 'Test Category';
                    ApplicationArea = All;
                }
                field("Cluster Option"; Rec."Cluster Option")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                        CurrPage.Update();
                    end;
                }
                group("Cluster Details")
                {
                    ShowCaption = false;
                    Visible = clustered;

                    field(Cluster; Rec.Cluster)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Scheduled Area")
                {
                    Visible = not clustered;

                    field(Branch; Rec.Branch)
                    {
                        ApplicationArea = All;
                    }
                    field(County; Rec.County)
                    {
                        ApplicationArea = All;
                    }
                    field("County Name"; Rec."County Name")
                    {
                        ApplicationArea = All;
                    }
                    field(Location; Rec.Location)
                    {
                        ApplicationArea = All;
                    }
                    field(Market; Rec.Market)
                    {
                        ApplicationArea = All;
                    }
                }
                field("Target No of Clients"; Rec."Target No of Clients")
                {
                    ApplicationArea = All;
                }
                //field(cl)
                label("Period details")
                {
                    Style = Strong;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    Caption = 'Period';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Proposed Start Date"; Rec."Proposed Start Date")
                {
                    ApplicationArea = All;
                }
                field("Proposed Start Time"; Rec."Proposed Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Proposed Start Time';
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = All;
                }
                field("Proposed End Time"; Rec."Proposed End Time")
                {
                    ApplicationArea = All;
                    Caption = 'Proposed End Time';
                }
            }
            group("Target Client")
            {
                part(Target; "Target Clients")
                {
                    SubPageLink = "Document No" = field(Code);
                    ApplicationArea = All;
                }
            }
            // Group("Testing Requirements")
            // {
            part(TestingReq; "Testing Resource Requirements")
            {
                Caption = 'Testing Requirements';
                SubPageLink = AllocationNo = FIELD(Code);
                ApplicationArea = All;
            }
            // }
            part("Testing target products"; "Testing target products")
            {
                Caption = 'Target Products';
                SubPageLink = AllocationNo = field(Code);
            }
            // part("Testing resource requirements"; "Testing resource requirements")
            // {
            //     Caption = 'Resource Requirements';
            //     SubPageLink = AllocationNo = field(Code);
            // }
            part("Testing Employee Allocation"; "Testing Employee Allocation")
            {
                Caption = 'Responsible Staff';
                SubPageLink = "Allocation No" = field(Code);
            }
        }
        area(FactBoxes)
        {
            systempart(Control53; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = not Rec.Scheduled;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EmployeeAlloc: Record "Testing Employee Allocation";
                begin
                    EmployeeAlloc.SetRange("Allocation No", Rec.Code);
                    EmployeeAlloc.SetFilter("Employee No", '<>%1', '');
                    if not EmployeeAlloc.Find('-') then
                        Error('You must specify at least one employee')
                    else
                        LabMgmt.SendScheduleNotice2(Rec);
                    CurrPage.Close();
                    exit;
                end;
            }
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec.Code, CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action(Reopen)
            {
                Visible = Rec.Scheduled;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Scheduled := false;
                    CurrPage.Close();
                end;
            }
            action(Close)
            {
                Visible = Rec.Scheduled;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Closed := true;
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance()
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        LabMgmt: Codeunit "Laboratory Management";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        clustered: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Cluster Option" = Rec."Cluster Option"::Cluster then
            clustered := true
        else
            clustered := false;
    end;
}
