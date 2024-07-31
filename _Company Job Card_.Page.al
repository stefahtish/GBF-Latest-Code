page 50397 "Company Job Card"
{
    PageType = Card;
    SourceTable = "Company Job";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                    ApplicationArea = All;
                }
                field("Job Designation"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job Description field';
                    ApplicationArea = All;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Dimension 2 field';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field';
                    ApplicationArea = All;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    Caption = 'Immediate Supervisor';
                    ToolTip = 'Specifies the value of the Immediate Supervisor field';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                    ApplicationArea = All;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Caption = 'In posts';
                    ToolTip = 'Specifies the value of the In posts field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    Caption = 'No of Establishments';
                    ToolTip = 'Specifies the value of the No of Establishments field';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Employee.Reset;
                        Employee.SetRange("Job Position", Rec."Job ID");
                        if Employee.Find('-') then begin
                            PAGE.Run(5201, Employee);
                        end;
                    end;
                }
                field(Vacancy; Rec.Vacancy)
                {
                    ToolTip = 'Specifies the value of the Vacancy field';
                    ApplicationArea = All;
                }
            }
            group("Objective/Function")
            {
                Caption = 'Objective/Function';

                field(Objective; Rec.Objective)
                {
                    Caption = 'Objectives';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Objectives field';
                    ApplicationArea = All;
                }
            }
            part(KeyJobResponsibilities; "Key Job Responsibilities")
            {
                caption = 'Duties and Responsibilities';
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(Academics; "Company Job Education")
            {
                Caption = 'Academic Qualifications';
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(Experience; "Company Job Experience")
            {
                Caption = 'Experience Qualifications';
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(KnowledgeRequired; "Knowledge Required")
            {
                caption = 'Knowledge and Skills Required';
                SubPageLink = Code = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalCourse; "Company Job Prof course")
            {
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalMembership; "Company Job Prof Membership")
            {
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part("Position Supervising"; "Positions Supervising")
            {
                Caption = 'Position Supervising';
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
            part(Attachments; "Job Attachments")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        DepartmentName := '';
        GetDeptName;
        HRManagement.GetVacantPositions(Rec);
    end;

    trigger OnOpenPage()
    begin
        DepartmentName := '';
        GetDeptName;
    end;

    var
        DepartmentName: Text;
        Employee: Record Employee;
        HRManagement: Codeunit "HR Management";
        Instr: InStream;
        OutStr: OutStream;
        KnowledgeBigTxt: BigText;
        KnowledgeTxt: Text;

    local procedure GetDeptName(): Text
    var
        Dimensions: Record "Dimension Value";
    begin
        Dimensions.Reset;
        Dimensions.SetRange(Code, Rec."Dimension 2");
        if Dimensions.Find('-') then begin
            DepartmentName := Dimensions.Name;
        end;
    end;
}
