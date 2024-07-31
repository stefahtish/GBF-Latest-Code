page 50620 "Training Evaluation Card"
{
    PageType = Card;
    SourceTable = "Training Evaluation Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Training Evaluation No."; Rec."Training Evaluation No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Training No."; Rec."Training No.")
                {
                    ApplicationArea = All;
                }
                field("Training Name"; Rec."Training Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Course Description"; Rec.Description)
                {
                    Caption = 'Course Description';
                    ApplicationArea = All;
                }
                field("Personal No."; Rec."Personal No.")
                {
                    ApplicationArea = All;
                }
                field("Name of the participant"; Rec."Name of participant")
                {
                    ApplicationArea = All;
                }
            }
            part(CourseTitle; "Training Evaluation Lines")
            {
                Caption = '1.	Describe the courses/subjects covered during the training (please use extra pages if required).';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Course);
            }
            part(KnowledgeSkills; "Training Evaluation Lines")
            {
                Caption = '2.	Propose how the knowledge and skills gained from the course can be utilized to further improve effective delivery of services and achieve the goals and objectives of your department and the Commission (please use extra pages if required  ';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Utilization);
            }
            part(Expectation; "Training Evaluation Lines")
            {
                Caption = '3.	Did the training meet your expectations?';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Expectation);
            }
            part(Impact; "Training Evaluation Lines")
            {
                Caption = '4.	What impact does the training have in your future skills, knowledge and professional capacity and the departmental objectives?';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Impact);
            }
            part(Improving; "Training Evaluation Lines")
            {
                Caption = 'And how to improve on my weak areas';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(ImprovingWeakness);
            }
            part(TrainingTechniques; "Training Evaluation Lines")
            {
                Caption = '5.	Describe the training techniques used in the delivery of the training.  ';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(TrainingTechniques);
            }
            part(TrainingFoodVenue; "Training Evaluation Lines")
            {
                Caption = '6.	Comment on the training venue/food quality etc';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(TrainingVenueFood);
            }
            part(Recommendation; "Training Evaluation Lines")
            {
                Caption = '7.	Would you recommend the Commission to nominate other participants to attend the same or other courses organized by the same trainer?';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Recommendation);
            }
            part(RecommendationNo; "Training Evaluation Lines")
            {
                Caption = 'If your answer is no, please explain';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(RecommendationNo);
            }
            part(PersonalActionPlans; "Training Evaluation Lines")
            {
                Caption = 'PERSONAL ACTION PLANS: (What actions are you putting in place to improve on your performance /training needs as a result of this training?)';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(PersonlActionPlans);
            }
            part(Barriers; "Training Evaluation Lines")
            {
                Caption = 'State the barriers that may impede the implementation of your action plans and how you intend to overcome them.';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(Barriers);
            }
            part(OverComingBarriers; "Training Evaluation Lines")
            {
                Caption = 'How To Overcome- assignments';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(OvercomingBarriers);
            }
            part(ReqResources; "Training Evaluation Lines")
            {
                Caption = 'State the resource requirements (people, equipments, extra skills) that will enable you implement the action plans.';
                SubPageLink = "Training Evaluation No." = field("Training Evaluation No."), "Personal No." = field("Personal No."), "Evaluation Line Type" = const(ResourceReq);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = Basic, suite;
                Image = Home;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.Submitted := true;
                end;
            }
        }
        area(reporting)
        {
            action("Training Evaluation Report")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Training Evaluation Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    EvalHeader: Record "Training Evaluation Header";
                begin
                    EvalHeader.RESET;
                    EvalHeader.SETRANGE(EvalHeader."Training Evaluation No.", Rec."Training Evaluation No.");
                    IF EvalHeader.FIND('-') THEN REPORT.RUN(Report::"Fuel Top up Schedule", TRUE, false, EvalHeader);
                end;
            }
        }
    }
}
