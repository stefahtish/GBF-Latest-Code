page 51441 "Post Training Evaluation"
{
    Caption = 'Post Training Evaluation';
    PageType = Card;
    SourceTable = "Post Training Evaluation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee No,"; Rec."Employee No,")
                {
                    ToolTip = 'Specifies the value of the Employee No, field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                    enabled = false;
                }
                field("P/No"; Rec."P/No")
                {
                    ToolTip = 'Specifies the value of the P/No field.';
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                    ApplicationArea = All;
                    enabled = false;
                }
                field(Ethnicity; Rec.Ethnicity)
                {
                    ToolTip = 'Specifies the value of the Ethnicity field.';
                    // ApplicationArea = All;
                    Enabled = false;
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                    ApplicationArea = All;
                    // Enabled = false;
                }
                field("Division/Unit"; Rec."Division/Unit")
                {
                    ToolTip = 'Specifies the value of the Division/Unit field.';
                    ApplicationArea = All;
                }
                field("Course Attended"; Rec."Course Attended")
                {
                    ToolTip = 'Specifies the value of the Course Attended field.';
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ToolTip = 'Specifies the value of the Venue field.';
                    ApplicationArea = All;
                }
                field("Course Dates"; Rec."Course Dates")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Course Dates field.';
                    ApplicationArea = All;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.';
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
                field(Submitted; Rec.Submitted)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Submitted field.';
                    ApplicationArea = All;
                }
                field(Archived; Rec.Archived)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Archived field.';
                    ApplicationArea = All;
                }
            }
            group("Employee")
            {
                Caption = 'Self-Assessment by Officer on Training and Impact on Performance';

                field(Relevancy; Rec.Relevancy)
                {
                    ToolTip = 'Specifies the value of the Relevancy field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part("Skills"; "Post Training Employee Skills")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            group("Knowledge applied By Employee")
            {
                field("Knowledge Applied"; Rec."Knowledge Applied")
                {
                    ToolTip = 'Specifies the value of the Knowledge Applied field.';
                    ApplicationArea = All;
                }
            }
            group("Knowledge1Explanation")
            {
                Visible = Rec."Knowledge Applied";
                ShowCaption = false;

                field("Knowledge Explanation"; Rec."Knowledge Explanation")
                {
                    ToolTip = 'Specifies the value of the Knowledge Explanation field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                part("Knowledge1 Explanation"; "Knowledge & Skills Explanation")
                {
                    Visible = false;
                    SubPageLink = "No." = field("No.");
                    ApplicationArea = all;
                }
            }
            part("Employee Recommendations"; "Employee Recommendations")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            group("HOD")
            {
                Visible = Rec.Submitted;
                ShowCaption = false;
                Caption = 'Head of Department/Division/Unit assessment on skills, knowledge, attitude and impact on Officers’ performance ';

                field("Employee Motivated"; Rec."Employee Motivated")
                {
                    ToolTip = 'Specifies the value of the Employee Motivated field.';
                    ApplicationArea = All;
                }
                field("Improved Performance"; Rec."Improved Performance")
                {
                    ToolTip = 'Specifies the value of the Improved Performance field.';
                    ApplicationArea = All;
                }
            }
            group("Explanation")
            {
                Visible = Rec.Submitted;
                ShowCaption = false;

                field("HOD Explanation"; Rec."HOD Explanation")
                {
                    ToolTip = 'Specifies the value of the HOD Explanation field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                part("HOD1 Explanation"; "HOD Explanation")
                {
                    visible = false;
                    SubPageLink = "No." = field("No.");
                    ApplicationArea = all;
                }
            }
            group("Work")
            {
                Visible = Rec.Submitted;
                ShowCaption = false;

                part("Affected Work"; "Affected Work")
                {
                    SubPageLink = "No." = field("No.");
                    ApplicationArea = all;
                }
            }
            group("T1raining Recommendation")
            {
                ShowCaption = false;
                Visible = Rec.Submitted;

                field("Training Recommendation"; Rec."Training Recommendation")
                {
                    ToolTip = 'Specifies the value of the Training Recommendation field.';
                    ApplicationArea = All;
                }
            }
            group("Training")
            {
                Visible = Rec.Submitted;
                ShowCaption = false;

                field("HOD Training"; Rec."HOD Training")
                {
                    ToolTip = 'Specifies the value of the HOD Training field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                part("HOD Training Explanation"; "HOD Training Explanation")
                {
                    Visible = false;
                    SubPageLink = "No." = field("No.");
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Submit")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                visible = not Rec.submitted;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Submit for Review?', false) = true then begin
                        Rec.Submitted := true;
                        Rec.Modify();
                    end;
                end;
            }
            action("Archive")
            {
                ApplicationArea = All;
                Image = Archive;
                Promoted = true;
                visible = Rec.submitted;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Archive this record?', false) = true then begin
                        Rec.Archived := true;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
    // procedure InsertDailyCharges()
    // var
    //     CustRec: Record Customer;
    //     DailyCharges: Record "Daily Charges";
    //     DailyChargeSetup: Record "Daily Charges Setup";
    //     DateDue: Date;
    //     Totalcharges: Decimal;
    // begin
    //     //loop through all the customers
    //     CustRec.Reset();
    //     If CustRec.FindSet() then begin
    //         repeat
    //             // get last daily charge date as the date due
    //             DailyCharges.Reset();
    //             DailyCharges.setrange("Customer No", CustRec."No.");
    //             If DailyCharges.findlast() then begin
    //                 DateDue := CalcDate(DailyChargeSetup."Daily Charge Duration", Today);
    //             end;
    //             // if the date due is today then insert daily charge
    //             If DateDue = Today then begin
    //                 //the fields to be inserted e.g. "Charge Amount" := DailyCharge."Amount";
    //             end;
    //             // get total amount for the customer
    //             DailyCharges.Reset();
    //             DailyCharges.setrange("Customer No", CustRec."No.");
    //             If DailyCharges.find('-') then begin
    //                 Totalcharges := DailyCharges.Calcsums(Amount);
    //             end;
    //             // or create a flowfield on the header card ya kucalculate sum ya all the charges. 
    //         until CustRec.Next() = 0;
    //     end;
    // end;
}
